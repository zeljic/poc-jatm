package com.zeljic.poc.api;

import com.zeljic.poc.api.list.ListBean;
import com.zeljic.poc.api.list.ListQuery;
import com.zeljic.poc.entity.Status;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.Response;

import java.util.List;

@Path("/api/status")
public class StatusResource extends ResourceBase
{
	{
		this.searchable = List.of("name");
	}

	@GET
	public List<Status> index(@BeanParam ListBean listBean)
	{
		var listQuery = new ListQuery<Status, StatusResource>();

		listQuery.setResource(this);
		listQuery.setListBean(listBean);

		return listQuery.execute(Status.class);
	}

	@GET
	@Path("/{id}")
	public Status get(Long id)
	{
		return Status.findById(id);
	}

	@POST
	@Transactional
	public Response create(Status status)
	{
		status.persist();

		return Response.ok(status).status(201).build();
	}

	@PUT
	@Transactional
	@Path("/{id}")
	public Response update(Status status, Long id)
	{
		Status entity = Status.findById(id);

		if (entity == null)
		{
			return Response.status(Response.Status.BAD_REQUEST).build();
		}

		entity.name = status.name;
		entity.color = status.color;

		return Response.ok(entity).build();
	}
}
