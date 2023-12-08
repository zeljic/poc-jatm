package com.zeljic.poc.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.*;
import org.hibernate.annotations.Check;

import java.time.LocalDateTime;
import java.util.Set;

@Entity
@Table(name = "silos")
public class Silo extends PanacheEntityBase
{
	@Id
	@Column(name = "id", nullable = false)
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Long id;

	@Column(name = "name", nullable = false)
	public String name;

	@Column(name = "description")
	public String description;

	@Check(constraints = "LENGTH(color) = 6 OR LENGTH(color) = 8")
	public String color;

	@Column(name = "lock", nullable = false)
	public Boolean lock;

	@Column(name = "from_dt", nullable = false)
	public LocalDateTime from_dt;

	@Column(name = "to_dt", nullable = false)
	public LocalDateTime to_dt;

	@Column(name = "created_at", nullable = false)
	public LocalDateTime createdAt;

	@Column(name = "updated_at")
	public LocalDateTime updatedAt;

	@Column(name = "deleted_at")
	public LocalDateTime deletedAt;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "status_id", nullable = false, foreignKey = @ForeignKey(name = "silos_status_id_fk"))
	public Status status;

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(
		name = "silos_tasks",
		joinColumns = @JoinColumn(name = "silo_id", foreignKey = @ForeignKey(name = "silos_tasks_silo_id_fk")),
		inverseJoinColumns = @JoinColumn(name = "task_id", foreignKey = @ForeignKey(name = "silos_tasks_task_id_fk"))
	)
	@JsonBackReference
	public Set<Task> tasks;
}
