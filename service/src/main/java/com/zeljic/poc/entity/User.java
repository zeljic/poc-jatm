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

	@Column(name = "created_at", nullable = false)
	public LocalDateTime createdAt;

	@Column(name = "updated_at")
	public LocalDateTime updatedAt;

	@Column(name = "deleted_at")
	public LocalDateTime deletedAt;

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(
		name = "users_tasks",
		joinColumns = @JoinColumn(name = "user_id", foreignKey = @ForeignKey(name = "users_tasks_user_id_fk")),
		inverseJoinColumns = @JoinColumn(name = "task_id", foreignKey = @ForeignKey(name = "users_tasks_task_id_fk"))
	)
	@JsonManagedReference
	public Set<Task> tasks;

	@ManyToMany(fetch = FetchType.EAGER)
	@JoinTable(
		name = "users_roles",
		joinColumns = @JoinColumn(name = "user_id", foreignKey = @ForeignKey(name = "users_roles_user_id_fk")),
		inverseJoinColumns = @JoinColumn(name = "role_id", foreignKey = @ForeignKey(name = "users_roles_role_id_fk"))
	)
	@JsonManagedReference
	public Set<Role> roles;
}
