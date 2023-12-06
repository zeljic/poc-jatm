package com.zeljic.poc.entity;

import io.quarkus.hibernate.orm.panache.PanacheEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

import java.time.LocalDateTime;

@Entity
@Table(name = "users")
public class User extends PanacheEntity
{
	@Column(length = 16, nullable = false)
	public String name;

	@Column(length = 6, nullable = false)
	public String code;

	@Column(length = 8, nullable = false)
	public String color;

	@Column(name = "created_at", nullable = false, updatable = false)
	public LocalDateTime createdAt;

	@Column(name = "updated_at")
	public LocalDateTime updatedAt;
}
