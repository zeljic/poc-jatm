package com.zeljic.poc.api.list;

import jakarta.enterprise.context.RequestScoped;
import org.eclipse.microprofile.config.inject.ConfigProperties;

@ConfigProperties(prefix = "poc-yatm.api.list")
@RequestScoped
public class ListQueryConfiguration
{
	public int limit = 10;
	public int maxLimit = 100;
	public int offset = 0;
	public String order = "desc";
	public String sort = "createdAt";
}
