package com.zeljic.poc.validation;

import jakarta.validation.constraints.NotBlank;
import org.hibernate.validator.constraints.Length;

public class User
{
	@NotBlank(message = "Name is required")
	public String name;

	@NotBlank(message = "Code is required")
	@Length(min = 6, max = 6, message = "Code must be 6 characters")
	public String code;

	@Length(min = 6, max = 8, message = "Color must be between 6 and 8 characters")
	public String color;
}
