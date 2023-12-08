package com.zeljic.poc;

import com.zeljic.poc.entity.Task;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

import java.util.List;

@Path("/api/tasks")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class Tasks
{
	@GET
	public List<Task> index()
	{
		return Task.listAll();
	}
}
