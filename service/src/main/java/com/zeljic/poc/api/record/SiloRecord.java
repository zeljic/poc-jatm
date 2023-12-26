package com.zeljic.poc.api.record;

import com.zeljic.poc.entity.Silo;

import java.util.List;

public record SiloRecord(
	String name,
	String description,
	String color,
	List<TaskRecord> tasks
)
{
	public static SiloRecord from(Silo silo, boolean tasks)
	{
		return new SiloRecord(
			silo.name,
			silo.description,
			silo.color,
			tasks ? silo.tasks.stream().map(TaskRecord::from).toList() : null
		);
	}

	public static SiloRecord from(Silo silo)
	{
		return from(silo, false);
	}
}
