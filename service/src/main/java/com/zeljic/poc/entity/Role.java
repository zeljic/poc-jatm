package com.zeljic.poc.entity;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.*;

import java.util.List;

@Entity
@Table(
	name = "roles",
	indexes = @Index(name = "role_name_index", columnList = "name"),
	uniqueConstraints = @UniqueConstraint(name = "role_name_unique", columnNames = "name")
)
public class Role extends PanacheEntityBase
{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Long id;

	@Column(name = "name", nullable = false, length = 32)
	public String name;

	public String description;

	@ManyToMany(fetch = FetchType.LAZY, mappedBy = "roles")
	public List<User> users;
}
