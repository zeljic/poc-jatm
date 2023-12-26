package com.zeljic.poc.api;

import com.zeljic.poc.api.list.ListBean;
import com.zeljic.poc.api.list.ListQuery;
import com.zeljic.poc.api.list.ListResult;
import com.zeljic.poc.api.record.UserRecord;
import com.zeljic.poc.entity.User;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.core.UriInfo;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Path("/api/users")
@Produces(MediaType.APPLICATION_JSON)
public class UsersResource extends ResourceBase
{
	{
		this.searchable = List.of("name", "email");
		this.filterable = List.of("name", "email");
	}

	@Inject
	ListQuery<User, UsersResource> listQuery;

	@GET
	public ListResult<UserRecord> index(@BeanParam ListBean listBean, @BeanParam WithBean withBean)
	{
		listQuery.setResource(this);
		listQuery.setListBean(listBean);

		var list = listQuery
			.execute(User.class)
			.stream()
			.map(user -> UserRecord.from(user, withBean.with("roles"), withBean.with("tasks")))
			.toList();

		var count = listQuery.count(User.class);

		return new ListResult<>(count, list);
	}

	@GET
	@Path("/{id}")
	public UserRecord get(@Valid @PathParam("id") UUID id, @Context UriInfo uriInfo)
	{
		User user = User.findById(id);

		if (user == null)
		{
			throw new NotFoundException();
		}

		boolean roles = uriInfo.getQueryParameters().containsKey("roles");
		boolean tasks = uriInfo.getQueryParameters().containsKey("tasks");

		return UserRecord.from(user, roles, tasks);
	}

	@POST
	@Transactional
	public Response create(@Valid User user)
	{
		user.persist();

		return Response.status(Response.Status.CREATED).build();
	}

	@PUT
	@Transactional
	@Path("/{id}")
	public Response update(@PathParam("id") UUID id, @Valid User user)
	{
		User entity = User.findById(id);

		if (entity == null)
		{
			return Response.status(Response.Status.BAD_REQUEST).build();
		}

		entity.email = user.email;
		entity.name = user.name;
		entity.color = user.color;

		entity.updatedAt = LocalDateTime.now();

		entity.persist();

		return Response.noContent().build();
	}

	// delete
	@DELETE
	@Transactional
	@Path("/{id}")
	public Response delete(@PathParam("id") UUID id)
	{
		User entity = User.findById(id);

		if (entity == null)
		{
			return Response.status(Response.Status.BAD_REQUEST).build();
		}

		entity.deletedAt = LocalDateTime.now();

		entity.persist();

		return Response.noContent().build();
	}
}
