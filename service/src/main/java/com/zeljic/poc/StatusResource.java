package com.zeljic.poc;

import com.zeljic.poc.entity.Status;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.PUT;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.core.Response;

import java.util.List;

@Path("/api/status")
public class StatusResource
{
	@GET
	public List<Status> index()
	{
		return Status.listAll();
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
