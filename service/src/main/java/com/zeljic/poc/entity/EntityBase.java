package com.zeljic.poc.entity;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.*;

import java.util.UUID;

@MappedSuperclass
public class EntityBase extends PanacheEntityBase
{
	@Id
	@GeneratedValue(strategy = GenerationType.UUID)
	@Column(name = "id")
	public UUID id;
}
