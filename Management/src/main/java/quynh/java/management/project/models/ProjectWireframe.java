package quynh.java.management.project.models;

import java.util.Set;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "project_wireframe")
public class ProjectWireframe {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String name;
	@Column(name = "wireframe_dia_text")
	private String wireframeDiaText;
	@Column(name = "usecase_dia_text")
	private String usecaseDiaText;
	@ManyToOne
	@JoinColumn(name = "project_id")
	private Project project;
	@OneToMany(mappedBy = "wireframe")
	private Set<ProjectUsecase> usecases;
}
