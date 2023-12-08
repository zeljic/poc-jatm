package com.zeljic.poc.entity;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.*;
import org.hibernate.annotations.Check;

import java.time.LocalDateTime;
import java.util.Set;

@Entity
@Table(
	name = "users",
	indexes = {
		@Index(name = "user_email_index", columnList = "email"),
		@Index(name = "user_name_index", columnList = "name")
	},
	uniqueConstraints = {
		@UniqueConstraint(name = "users_email_unique", columnNames = "email"),
		@UniqueConstraint(name = "users_name_unique", columnNames = "name")
	}
)
public class User extends PanacheEntityBase
{
	@Id
	@Column(name = "id", nullable = false)
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Long id;

	@Column(name = "email", nullable = false)
	public String email;

	@Column(length = 16, nullable = false)
	public String name;

	@Column(name = "password", nullable = false)
	public String password;

	@Column(length = 8)
	@Check(constraints = "LENGTH(color) = 6 OR LENGTH(color) = 8")
	public String color;

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(
		name = "tasks_users",
		joinColumns = @JoinColumn(name = "user_id", foreignKey = @ForeignKey(name = "task_user_user_id_fk")),
		inverseJoinColumns = @JoinColumn(name = "task_id", foreignKey = @ForeignKey(name = "task_user_task_id_fk"))
	)
	@JsonManagedReference
	public Set<Task> tasks;

	@Column(name = "created_at", nullable = false, columnDefinition = "now()")
	public LocalDateTime createdAt;

	@Column(name = "updated_at")
	public LocalDateTime updatedAt;

	@Column(name = "deleted_at")
	public LocalDateTime deletedAt;
}
