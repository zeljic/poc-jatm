package com.zeljic.poc.entity;

import jakarta.persistence.*;
import org.hibernate.annotations.Check;
import org.hibernate.annotations.Generated;
import org.hibernate.generator.EventType;

import java.time.LocalDateTime;

@Entity
@Table(
	name = "teams",
	indexes = @Index(name = "team_name_index", columnList = "name"),
	uniqueConstraints = @UniqueConstraint(name = "team_name_unique", columnNames = "name")
)
public class Team extends EntityBase
{
	@Column(name = "name", nullable = false)
	public String name;

	@Column(name = "description")
	public String description;

	@Check(constraints = "LENGTH(color) = 6 OR LENGTH(color) = 8")
	public String color;

	@Column(name = "created_at", nullable = false, updatable = false, columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
	@Generated(event = EventType.INSERT)
	public LocalDateTime createdAt;

	@Column(name = "updated_at")
	public LocalDateTime updatedAt;

	@Column(name = "deleted_at")
	public LocalDateTime deletedAt;
}
