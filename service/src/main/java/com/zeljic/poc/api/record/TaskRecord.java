package com.zeljic.poc.api.record;

import com.zeljic.poc.entity.Status;
import com.zeljic.poc.entity.Task;

import java.util.List;

public record TaskRecord(
	String name,
	String description,
	String color,
	Status status,
	List<UserRecord> users,
	List<SiloRecord> silos
)
{
	public static TaskRecord from(Task task, boolean users, boolean silos)
	{
		return new TaskRecord(
			task.name,
			task.description,
			task.color,
			task.status,
			users ? task.users.stream().map(UserRecord::from).toList() : null,
			silos ? task.silos.stream().map(SiloRecord::from).toList() : null
		);
	}

	public static TaskRecord from(Task task)
	{
		return from(task, false, false);
	}
}
