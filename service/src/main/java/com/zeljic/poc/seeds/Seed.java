package com.zeljic.poc.seeds;

import com.github.javafaker.Faker;
import com.zeljic.poc.entity.*;
import io.quarkus.narayana.jta.QuarkusTransaction;
import io.quarkus.runtime.LaunchMode;
import io.quarkus.runtime.Startup;
import jakarta.annotation.PostConstruct;
import jakarta.inject.Inject;
import org.eclipse.microprofile.config.inject.ConfigProperty;

import java.util.Locale;

@Startup
public class Seed
{
	protected final Faker faker = new Faker(Locale.ITALIAN);

	@Inject
	@ConfigProperty(name = "poc-yatm.schema.seed", defaultValue = "false")
	private boolean seed;

	protected boolean isDevelopment()
	{
		return LaunchMode.current() == LaunchMode.DEVELOPMENT && seed;
	}

	@PostConstruct
	public void seed()
	{
		if (!isDevelopment())
		{
			return;
		}

		QuarkusTransaction.requiringNew().run(() ->
		{
			Task.deleteAll();
			Silo.deleteAll();
			Status.deleteAll();
			User.deleteAll();
			Team.deleteAll();
		});

		QuarkusTransaction.requiringNew().run(() -> new UsersSeed().seed(faker, 100));

		QuarkusTransaction.requiringNew().run(() -> new StatusSeed().seed(faker));

		QuarkusTransaction.requiringNew().run(() -> new TaskSeed().seed(faker, 1000));

		QuarkusTransaction.requiringNew().run(() -> new TeamSeed().seed(faker, 10));

		QuarkusTransaction.requiringNew().run(() -> new SiloSeed().seed(faker, 20));
	}
}
