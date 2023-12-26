package com.zeljic.poc.seeds;

import com.github.javafaker.Faker;
import com.zeljic.poc.entity.Status;
import com.zeljic.poc.entity.Task;
import io.quarkus.panache.common.Sort;
import jakarta.transaction.Transactional;

public class TaskSeed
{
	@Transactional
	public void seed(final Faker faker, int count)
	{
		for (int i = 0; i < count; i++)
		{
			var task = new Task();

			task.name = "Find " + faker.starTrek().character() + " on " + faker.starTrek().location();
			task.description = faker.lorem().paragraph();
			task.color = faker.regexify("[a-f0-9]{6}");
			task.status = Status.findAll(Sort.ascending("id")).firstResult();

			task.persist();
		}
	}
}
