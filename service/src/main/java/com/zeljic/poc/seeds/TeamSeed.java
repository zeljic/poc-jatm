package com.zeljic.poc.seeds;

import com.github.javafaker.Faker;
import com.zeljic.poc.entity.Team;
import jakarta.transaction.Transactional;

public class TeamSeed
{
	@Transactional
	public void seed(final Faker faker, int count)
	{
		for (int i = 0; i < count; i++)
		{
			var team = new Team();

			team.name = faker.team().name();
			team.description = faker.lorem().paragraph(1);
			team.color = faker.regexify("[a-f0-9]{6}");

			team.persist();
		}
	}
}
