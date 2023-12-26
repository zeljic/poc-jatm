package com.zeljic.poc.seeds;

import com.github.javafaker.Faker;
import com.zeljic.poc.entity.Silo;
import com.zeljic.poc.entity.Status;
import io.quarkus.panache.common.Sort;
import jakarta.transaction.Transactional;

public class SiloSeed
{
	@Transactional
	public void seed(final Faker faker, int count)
	{
		for (int i = 0; i < count; i++)
		{
			var silo = new Silo();
			var from = (int) (Math.random() * 1000);
			var to = from + (int) (Math.random() * 1000);

			silo.name = faker.rickAndMorty().location() + " of " + faker.pokemon().name();
			silo.description = "Alien planet with a lot of dangerous creatures like " + faker.pokemon().name();
			silo.color = faker.regexify("[a-f0-9]{6}");
			silo.status = Status.findAll(Sort.ascending("id")).firstResult();
			silo.from = faker.date().past(from, java.util.concurrent.TimeUnit.DAYS).toInstant().atZone(java.time.ZoneId.systemDefault()).toLocalDateTime();
			silo.to = faker.date().past(to, java.util.concurrent.TimeUnit.DAYS).toInstant().atZone(java.time.ZoneId.systemDefault()).toLocalDateTime();
			silo.status = Status.findAll(Sort.ascending("id")).firstResult();
			silo.color = faker.regexify("[a-f0-9]{6}");
			silo.lock = faker.bool().bool();

			silo.persist();
		}
	}
}
