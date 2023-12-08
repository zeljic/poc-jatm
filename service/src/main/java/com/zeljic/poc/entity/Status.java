package com.zeljic.poc.entity;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.*;

@Entity
@Table(
	name = "statuses",
	indexes = @Index(name = "status_name_index", columnList = "name"),
	uniqueConstraints = @UniqueConstraint(name = "status_name_unique", columnNames = "name")
)
public class Status extends PanacheEntityBase
{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Long id;

	@Column(name = "name", nullable = false)
	public String name;

	public String description;

	@Column(length = 8)
	public String color;
}
