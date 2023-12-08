package com.zeljic.poc.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.*;
import org.hibernate.annotations.Check;

import java.time.LocalDateTime;
import java.util.Set;

@Entity
@Table(
	name = "tasks",
	indexes = @Index(name = "task_name_index", columnList = "name"),
	uniqueConstraints = @UniqueConstraint(name = "task_name_unique", columnNames = "name")
)
public class Task extends PanacheEntityBase
{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Long id;

	@Column(name = "name", nullable = false)
	public String name;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "status_id", nullable = false, foreignKey = @ForeignKey(name = "task_status_id_fk"))
	public Status status;

	@ManyToMany(fetch = FetchType.LAZY, mappedBy = "tasks")
	@JsonBackReference
	public Set<User> users;

	@Column(name = "description", columnDefinition = "text")
	public String description;

	@Check(constraints = "LENGTH(color) = 6 OR LENGTH(color) = 8")
	public String color;

	@Column(name = "created_at", nullable = false, columnDefinition = "now()")
	public LocalDateTime createdAt;

	@Column(name = "updated_at")
	public LocalDateTime updatedAt;

	@Column(name = "deleted_at")
	public LocalDateTime deletedAt;
}
