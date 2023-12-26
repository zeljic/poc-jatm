package com.zeljic.poc.api.list;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

public class ListResult<T>
{
	@JsonProperty("total")
	public long total;

	@JsonProperty("data")
	public List<T> data;

	@JsonCreator
	public ListResult(
		@JsonProperty("total") long total,
		@JsonProperty("data") List<T> data
	)
	{
		this.total = total;
		this.data = data;
	}
}
