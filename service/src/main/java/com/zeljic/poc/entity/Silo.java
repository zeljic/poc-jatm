package com.zeljic.poc.entity;

import jakarta.persistence.*;
import org.hibernate.annotations.Check;
import org.hibernate.annotations.Generated;
import org.hibernate.generator.EventType;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "silos")
public class Silo extends EntityBase
{
	@Column(name = "name", nullable = false)
	public String name;

	@Column(name = "description")
	public String description;

	@Check(constraints = "LENGTH(color) = 6 OR LENGTH(color) = 8")
	public String color;

	@Column(name = "lock", nullable = false)
	public Boolean lock;

	@Column(name = "from_dt", nullable = false)
	public LocalDateTime from;

	@Column(name = "to_dt", nullable = false)
	public LocalDateTime to;

	@Column(name = "created_at", nullable = false, updatable = false, columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
	@Generated(event = EventType.INSERT)
	public LocalDateTime createdAt;

	@Column(name = "updated_at")
	public LocalDateTime updatedAt;

	@Column(name = "deleted_at")
	public LocalDateTime deletedAt;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "status_id", nullable = false, foreignKey = @ForeignKey(name = "silos_status_id_fk"))
	public Status status;

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(
		name = "silos_tasks",
		joinColumns = @JoinColumn(name = "silo_id", foreignKey = @ForeignKey(name = "silos_tasks_silo_id_fk")),
		inverseJoinColumns = @JoinColumn(name = "task_id", foreignKey = @ForeignKey(name = "silos_tasks_task_id_fk"))
	)
	public List<Task> tasks;
}
