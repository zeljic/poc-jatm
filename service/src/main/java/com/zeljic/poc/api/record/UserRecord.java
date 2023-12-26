package com.zeljic.poc.api.record;

import com.zeljic.poc.api.WithBean;
import com.zeljic.poc.entity.User;

import java.util.List;
import java.util.UUID;

public record UserRecord(
	UUID id,
	String name,
	String email,
	String color,
	List<RoleRecord> roles,
	List<TaskRecord> tasks
)
{
	public static UserRecord from(User user, boolean roles, boolean tasks)
	{
		return new UserRecord(
			user.id,
			user.name,
			user.email,
			user.color,
			roles ? user.roles.stream().map(RoleRecord::from).toList() : null,
			tasks ? user.tasks.stream().map(TaskRecord::from).toList() : null
		);
	}

	public static UserRecord from(User user, WithBean withBean)
	{
		return from(user, withBean.with("roles"), withBean.with("tasks"));
	}

	public static UserRecord from(User user)
	{
		return from(user, false, false);
	}
}
