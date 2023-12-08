package com.zeljic.poc;

import com.zeljic.poc.entity.User;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import java.time.LocalDateTime;
import java.util.List;

@Path("/api/users")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class UsersResource
{
	@GET
	public List<User> index()
	{
		return User.listAll();
	}

	@GET
	@Path("/{id}")
	public User get(Long id)
	{
		return User.findById(id);
	}

	@POST
	@Transactional
	public Response create(@Valid User user)
	{
		user.persist();

		return Response.ok(user).status(201).build();
	}

	@PUT
	@Transactional
	@Path("/{id}")
	public Response update(@PathParam("id") Long id, User user)
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

		return Response.ok(entity).build();
	}

	// delete
	@DELETE
	@Transactional
	@Path("/{id}")
	public Response delete(@PathParam("id") Long id)
	{
		User entity = User.findById(id);

		if (entity == null)
		{
			return Response.status(Response.Status.BAD_REQUEST).build();
		}

		entity.delete();

		return Response.ok(entity).build();
	}
}
