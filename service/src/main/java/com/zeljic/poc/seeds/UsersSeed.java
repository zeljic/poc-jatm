package com.zeljic.poc.seeds;

import com.github.javafaker.Faker;
import com.zeljic.poc.entity.User;
import jakarta.transaction.Transactional;

public class UsersSeed
{
	@Transactional
	public void seed(final Faker faker, int count)
	{
		for (int i = 0; i < count; i++)
		{
			var user = new User();

			var email = faker.internet().emailAddress();

			while (User.count("email", email) > 0)
			{
				email = faker.internet().emailAddress();
			}

			user.email = email;
			user.name = faker.name().fullName();
			user.password = faker.internet().password();
			user.color = faker.regexify("[a-f0-9]{6}");

			user.persist();
		}
	}
}
