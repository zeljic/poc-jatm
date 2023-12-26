package com.zeljic.poc.api;

import jakarta.ws.rs.QueryParam;

import java.util.Set;

public class WithBean
{
	@QueryParam("with[]")
	public Set<String> withParam = Set.of();

	public boolean with(String name)
	{
		return withParam.contains(name);
	}
}
