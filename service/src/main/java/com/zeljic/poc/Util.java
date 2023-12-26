package com.zeljic.poc;

import java.util.Optional;

public class Util
{
	public static Optional<Integer> parseInteger(String value)
	{
		try
		{
			return Optional.of(Integer.parseInt(value));
		} catch (NumberFormatException e)
		{
			return Optional.empty();
		}
	}
}
