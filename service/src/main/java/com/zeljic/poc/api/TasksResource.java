package com.zeljic.poc.api;

import com.zeljic.poc.api.list.ListBean;
import com.zeljic.poc.api.list.ListQuery;
import com.zeljic.poc.api.record.TaskRecord;
import com.zeljic.poc.entity.Task;
import jakarta.ws.rs.BeanParam;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

import java.util.List;

@Path("/api/tasks")
@Produces(MediaType.APPLICATION_JSON)
public class TasksResource extends ResourceBase
{
	@GET
	public List<TaskRecord> index(@BeanParam ListBean listBean)
	{
		this.searchable = List.of("title", "description");

		var listQuery = new ListQuery<Task, TasksResource>();

		listQuery.setResource(this);
		listQuery.setListBean(listBean);

		return listQuery.execute(Task.class)
			.stream()
			.map(task -> TaskRecord.from(task, true, true))
			.toList();
	}
}
