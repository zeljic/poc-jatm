package com.zeljic.poc.api.list;

import io.quarkus.panache.common.Sort;
import jakarta.inject.Inject;
import jakarta.ws.rs.QueryParam;
import org.eclipse.microprofile.config.inject.ConfigProperties;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class ListBean
{
	@Inject
	@ConfigProperties
	ListQueryConfiguration listQueryConfiguration;

	public enum Trashed
	{
		// return all records
		ALL,
		// return only deleted records
		DELETED,
		// return only not deleted records
		NOT_DELETED
	}

	@QueryParam("search")
	public String searchParam = null;

	public String getSearch()
	{
		return searchParam;
	}

	@QueryParam("sort")
	public String sortParam = null;

	public String getSort()
	{
		return sortParam != null ? sortParam : listQueryConfiguration.sort;
	}

	@QueryParam("order")
	public String orderParam = null;

	public Sort.Direction getOrder()
	{
		if (orderParam == null)
		{
			orderParam = listQueryConfiguration.order;
		}

		return orderParam.equalsIgnoreCase("desc") ? Sort.Direction.Descending : Sort.Direction.Ascending;
	}

	@QueryParam("limit")
	public int limitParam = 0;

	public int getLimit()
	{
		return limitParam != 0 ? Math.min(limitParam, listQueryConfiguration.maxLimit) : listQueryConfiguration.limit;
	}

	@QueryParam("offset")
	public int offsetParam = 0;

	public int getOffset()
	{
		return offsetParam != 0 ? offsetParam : listQueryConfiguration.offset;
	}

	@QueryParam("filter[]")
	public Set<String> filterParam = Set.of();

	public Map<String, String> getFilter()
	{
		var map = new HashMap<String, String>();

		for (var filter : filterParam)
		{
			var first = filter.indexOf(':');

			if (first != -1)
			{
				var key = filter.substring(0, first);
				var value = filter.substring(first + 1);

				map.put(key, value);
			}
		}

		return map;
	}

	@QueryParam("trashed")
	public String trashedParam = null;

	public Trashed getTrashed()
	{
		if (trashedParam == null)
		{
			return Trashed.ALL;
		}

		return switch (trashedParam)
		{
			case "true" -> Trashed.DELETED;
			case "false" -> Trashed.NOT_DELETED;
			default -> Trashed.ALL;
		};
	}
}
