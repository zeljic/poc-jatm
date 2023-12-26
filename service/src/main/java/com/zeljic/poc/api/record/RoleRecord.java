package com.zeljic.poc.api.record;

import com.zeljic.poc.entity.Role;

public record RoleRecord(
	String name,
	String description
)
{
	public static RoleRecord from(Role role)
	{
		return new RoleRecord(role.name, role.description);
	}
}
