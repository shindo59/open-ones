/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package mks.dms.dao.entity;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author ThachLe
 */
@Entity
@Table(name = "user")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "User.findAll", query = "SELECT u FROM User u"),
    @NamedQuery(name = "User.findById", query = "SELECT u FROM User u WHERE u.id = :id"),
    @NamedQuery(name = "User.findByUsername", query = "SELECT u FROM User u WHERE u.username = :username"),
    @NamedQuery(name = "User.findByEnabled", query = "SELECT u FROM User u WHERE u.enabled = :enabled")})
public class User implements Serializable {
    @Basic(optional = false)
    @Column(name = "CREATED")
    @Temporal(TemporalType.TIMESTAMP)
    private Date created;
    @Column(name = "CREATEDBY_ID")
    private Integer createdbyId;
    @Column(name = "CREATEDBY_ACCOUNT")
    private String createdbyAccount;
    @Column(name = "CREATEDBY_NAME")
    private String createdbyName;
    @Column(name = "LASTMODIFIED")
    @Temporal(TemporalType.TIMESTAMP)
    private Date lastmodified;
    @Column(name = "LASTMODIFIEDBY_ID")
    private Integer lastmodifiedbyId;
    @Column(name = "LASTMODIFIEDBY_NAME")
    private String lastmodifiedbyName;
    @Column(name = "LASTMODIFIEDBY_ACCOUNT")
    private String lastmodifiedbyAccount;
    @Column(name = "CD")
    private String cd;
    @Column(name = "EMAIL")
    private String email;
    @Column(name = "DEPARTMENT_ID")
    private Integer departmentId;
    @Column(name = "DEPARTMENT_CD")
    private String departmentCd;
    @Column(name = "DEPARTMENT_NAME")
    private String departmentName;
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID")
    private Integer id;
    @Column(name = "USERNAME")
    private String username;
    @Column(name = "ENABLED")
    private Boolean enabled;
    @OneToMany(mappedBy = "createdbyId")
    private Collection<Request> requestCollection;
    @OneToMany(mappedBy = "managerId")
    private Collection<Request> requestCollection1;
    @OneToMany(mappedBy = "assignedId")
    private Collection<Request> requestCollection2;
    @OneToMany(mappedBy = "userId")
    private Collection<Role> roleCollection;
    @OneToMany(mappedBy = "userId")
    private Collection<Watcher> watcherCollection;

    public User() {
    }

    public User(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Boolean getEnabled() {
        return enabled;
    }

    public void setEnabled(Boolean enabled) {
        this.enabled = enabled;
    }

    @XmlTransient
    public Collection<Request> getRequestCollection() {
        return requestCollection;
    }

    public void setRequestCollection(Collection<Request> requestCollection) {
        this.requestCollection = requestCollection;
    }

    @XmlTransient
    public Collection<Request> getRequestCollection1() {
        return requestCollection1;
    }

    public void setRequestCollection1(Collection<Request> requestCollection1) {
        this.requestCollection1 = requestCollection1;
    }

    @XmlTransient
    public Collection<Request> getRequestCollection2() {
        return requestCollection2;
    }

    public void setRequestCollection2(Collection<Request> requestCollection2) {
        this.requestCollection2 = requestCollection2;
    }

    @XmlTransient
    public Collection<Role> getRoleCollection() {
        return roleCollection;
    }

    public void setRoleCollection(Collection<Role> roleCollection) {
        this.roleCollection = roleCollection;
    }

    @XmlTransient
    public Collection<Watcher> getWatcherCollection() {
        return watcherCollection;
    }

    public void setWatcherCollection(Collection<Watcher> watcherCollection) {
        this.watcherCollection = watcherCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof User)) {
            return false;
        }
        User other = (User) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "mks.dms.dao.entity.User[ id=" + id + " ]";
    }

    public String getCd() {
        return cd;
    }

    public void setCd(String cd) {
        this.cd = cd;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Integer getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(Integer departmentId) {
        this.departmentId = departmentId;
    }

    public String getDepartmentCd() {
        return departmentCd;
    }

    public void setDepartmentCd(String departmentCd) {
        this.departmentCd = departmentCd;
    }

    public String getDepartmentName() {
        return departmentName;
    }

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }

    public Date getCreated() {
        return created;
    }

    public void setCreated(Date created) {
        this.created = created;
    }

    public Integer getCreatedbyId() {
        return createdbyId;
    }

    public void setCreatedbyId(Integer createdbyId) {
        this.createdbyId = createdbyId;
    }

    public String getCreatedbyAccount() {
        return createdbyAccount;
    }

    public void setCreatedbyAccount(String createdbyAccount) {
        this.createdbyAccount = createdbyAccount;
    }

    public String getCreatedbyName() {
        return createdbyName;
    }

    public void setCreatedbyName(String createdbyName) {
        this.createdbyName = createdbyName;
    }

    public Date getLastmodified() {
        return lastmodified;
    }

    public void setLastmodified(Date lastmodified) {
        this.lastmodified = lastmodified;
    }

    public Integer getLastmodifiedbyId() {
        return lastmodifiedbyId;
    }

    public void setLastmodifiedbyId(Integer lastmodifiedbyId) {
        this.lastmodifiedbyId = lastmodifiedbyId;
    }

    public String getLastmodifiedbyName() {
        return lastmodifiedbyName;
    }

    public void setLastmodifiedbyName(String lastmodifiedbyName) {
        this.lastmodifiedbyName = lastmodifiedbyName;
    }

    public String getLastmodifiedbyAccount() {
        return lastmodifiedbyAccount;
    }

    public void setLastmodifiedbyAccount(String lastmodifiedbyAccount) {
        this.lastmodifiedbyAccount = lastmodifiedbyAccount;
    }
    
}
