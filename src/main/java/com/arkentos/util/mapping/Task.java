package com.arkentos.util.mapping;
// Generated Mar 26, 2018 11:02:46 AM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Task generated by hbm2java
 */
@Entity
@Table(name="TASK")
public class Task  implements java.io.Serializable {


     private String taskcode;
     private Status status;
     private String description;
     private Byte sortkey;
     private Set<Pagetask> pagetasks = new HashSet<Pagetask>(0);

    public Task() {
    }

	
    public Task(String taskcode) {
        this.taskcode = taskcode;
    }
    public Task(String taskcode, Status status, String description, Byte sortkey, Set<Pagetask> pagetasks) {
       this.taskcode = taskcode;
       this.status = status;
       this.description = description;
       this.sortkey = sortkey;
       this.pagetasks = pagetasks;
    }
   
     @Id 

    
    @Column(name="TASKCODE", unique=true, nullable=false, length=4)
    public String getTaskcode() {
        return this.taskcode;
    }
    
    public void setTaskcode(String taskcode) {
        this.taskcode = taskcode;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="STATUS")
    public Status getStatus() {
        return this.status;
    }
    
    public void setStatus(Status status) {
        this.status = status;
    }

    
    @Column(name="DESCRIPTION", length=64)
    public String getDescription() {
        return this.description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }

    
    @Column(name="SORTKEY", precision=2, scale=0)
    public Byte getSortkey() {
        return this.sortkey;
    }
    
    public void setSortkey(Byte sortkey) {
        this.sortkey = sortkey;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="task")
    public Set<Pagetask> getPagetasks() {
        return this.pagetasks;
    }
    
    public void setPagetasks(Set<Pagetask> pagetasks) {
        this.pagetasks = pagetasks;
    }




}

