package com.zeljic.poc;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

import java.util.Map;

@Path("/api")
public class Index
{
	@GET
	@Path("")
	@Produces(MediaType.APPLICATION_JSON)
	public Map<String, String> index()
	{
		return Map.of("message", "zdravo svete");
	}
}
