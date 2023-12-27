package com.zeljic.poc.api.list;

import com.zeljic.poc.api.ResourceBase;
import jakarta.enterprise.context.Dependent;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Predicate;
import jakarta.persistence.criteria.Root;

import java.util.List;

@Dependent
public class ListQuery<T, R extends ResourceBase>
{
	private R resource = null;
	private ListBean listBean = null;

	private CriteriaBuilder criteriaBuilder;

	@Inject
	EntityManager entityManager;

	public void setResource(R resource)
	{
		this.resource = resource;
	}

	public void setListBean(ListBean listBean)
	{
		this.listBean = listBean;
	}

	public List<T> execute(Class<T> clazz)
	{
		criteriaBuilder = entityManager.getCriteriaBuilder();

		var criteriaQuery = criteriaBuilder.createQuery(clazz);
		var root = criteriaQuery.from(clazz);

		criteriaQuery.distinct(true);

		scopeSearch(criteriaQuery, root);

		scopeFilter(criteriaQuery, root);

		scopeTrashed(criteriaQuery, root);

		scopeOrder(criteriaQuery, root);

		return entityManager.createQuery(criteriaQuery)
			.setFirstResult(this.listBean.getOffset())
			.setMaxResults(this.listBean.getLimit())
			.getResultList();
	}

	public Long count(Class<T> clazz)
	{
		var criteriaBuilder = entityManager.getCriteriaBuilder();
		var criteriaQuery = criteriaBuilder.createQuery(Long.class);
		var root = criteriaQuery.from(clazz);

		criteriaQuery.select(criteriaBuilder.count(root));

		scopeSearch(criteriaQuery, root);

		scopeFilter(criteriaQuery, root);

		scopeTrashed(criteriaQuery, root);

		return entityManager.createQuery(criteriaQuery).getSingleResult();
	}

	private void scopeTrashed(final CriteriaQuery<?> criteriaQuery, final Root<?> root)
	{
		switch (this.listBean.getTrashed())
		{
			case DELETED -> criteriaQuery.where(criteriaBuilder.isNotNull(root.get("deletedAt")));
			case NOT_DELETED -> criteriaQuery.where(criteriaBuilder.isNull(root.get("deletedAt")));
		}
	}

	private void scopeSearch(final CriteriaQuery<?> criteriaQuery, final Root<?> root)
	{
		var searchable = this.resource.searchable;
		var search = this.listBean.getSearch();

		if (search == null || search.isEmpty() || searchable == null || searchable.isEmpty())
		{
			return;
		}

		final var searchTerm = "%" + search.toLowerCase() + "%";

		// TODO: how to do case-insensitive search? lower will break indexes and performance will suffer on large tables
		List<Predicate> predicates = searchable
			.stream()
			.map(item -> criteriaBuilder.like(criteriaBuilder.lower(root.get(item)), searchTerm))
			.toList();

		Predicate combinedPredicate = criteriaBuilder.or(predicates.toArray(new Predicate[0]));

		criteriaQuery.where(combinedPredicate);
	}

	private void scopeOrder(final CriteriaQuery<?> criteriaQuery, final Root<?> root)
	{
		var key = root.get(this.listBean.getSort());

		switch (this.listBean.getOrder())
		{
			case Ascending -> criteriaQuery.orderBy(criteriaBuilder.asc(key));
			case Descending -> criteriaQuery.orderBy(criteriaBuilder.desc(key));
		}
	}

	private void scopeFilter(final CriteriaQuery<?> criteriaQuery, final Root<?> root)
	{
		this.listBean.getFilter().forEach((key, value) ->
		{
			criteriaQuery.where(criteriaBuilder.equal(root.get(key), value));
		});
	}

}
