package com.zeljic.poc.seeds;

import com.github.javafaker.Faker;
import com.zeljic.poc.entity.Status;
import io.quarkus.runtime.Startup;
import jakarta.transaction.Transactional;

@Startup
public class StatusSeed
{
	@Transactional
	public void seed(final Faker faker)
	{
		var status = new Status();

		status.name = "New";
		status.description = faker.book().title();
		status.color = faker.regexify("[a-f0-9]{6}");

		status.persist();

		status = new Status();

		status.name = "In Progress";
		status.description = faker.book().title();
		status.color = faker.regexify("[a-f0-9]{6}");

		status.persist();

		status = new Status();

		status.name = "Review";
		status.description = faker.book().title();
		status.color = faker.regexify("[a-f0-9]{6}");

		status.persist();

		status = new Status();

		status.name = "Acceptance";
		status.description = faker.book().title();
		status.color = faker.regexify("[a-f0-9]{6}");

		status.persist();

		status = new Status();

		status.name = "Done";
		status.description = faker.book().title();
		status.color = faker.regexify("[a-f0-9]{6}");

		status.persist();
	}
}
