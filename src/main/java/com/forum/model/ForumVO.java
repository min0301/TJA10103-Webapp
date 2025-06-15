package com.forum.model;

	import java.io.Serializable;
	import java.sql.Date;

import com.forumcategory.model.ForumCategoryVO;

import jakarta.persistence.*;
	
	@Entity
	@Table (name = "FORUM")
	public class ForumVO implements Serializable {
		

		@Id
		@GeneratedValue(strategy = GenerationType.IDENTITY)
		@Column(name = "FOR_NO")
		private Integer forNo;
		@Column(name = "FOR_NAME")
		private String forName;
		
		@ManyToOne
		@JoinColumn(name = "CAT_NO" , referencedColumnName = "CAT_NO")
		private ForumCategoryVO forumCategoryVO;
		
		private Integer catNo;
		private String catName;


		@Column(name = "FOR_DES")
		private String forDes;
		@Column(name = "FOR_DATE")
		private Date  forDate;
		@Column(name = "FOR_UPDATE")
		private Date  forUpdate;
		@Column(name = "FCHAT_STATUS")
		private Integer fchatStatus;
		
		
		
		public ForumVO() {
			super();
		}
		
		public ForumVO(Integer forNo, String forName, Integer catNo, String forDes, Date forDate, Date forUpdate,
				Integer fchatStatus) {
			super();
			this.forNo = forNo;
			this.forName = forName;
			this.catNo = catNo;
			this.forDes = forDes;
			this.forDate = forDate;
			this.forUpdate = forUpdate;
			this.fchatStatus = fchatStatus;
		}
		public Integer getForNo() {
			return forNo;
		}
		public void setForNo(Integer forNo) {
			this.forNo = forNo;
		}
		public String getForName() {
			return forName;
		}
		public void setForName(String forName) {
			this.forName = forName;
		}
		public Integer getCatNo() {
			return catNo;
		}
		public void setCatNo(Integer catNo) {
			this.catNo = catNo;
		}
		public String getForDes() {
			return forDes;
		}
		public void setForDes(String forDes) {
			this.forDes = forDes;
		}
		public Date getForDate() {
			return forDate;
		}
		public void setForDate(Date forDate) {
			this.forDate = forDate;
		}
		public Date getForUpdate() {
			return forUpdate;
		}
		public void setForUpdate(Date forUpdate) {
			this.forUpdate = forUpdate;
		}
		public Integer getFchatStatus() {
			return fchatStatus;
		}
		public void setFchatStatus(Integer fchatStatus) {
			this.fchatStatus = fchatStatus;
		}
		
		public String getCatName() {
			return catName;
		}

		public void setCatName(String catName) {
			this.catName = catName;
		}
		
		public ForumCategoryVO getForumCategoryVO() {
			return forumCategoryVO;
		}

		public void setForumCategoryVO(ForumCategoryVO forumCategoryVO) {
			this.forumCategoryVO = forumCategoryVO;
		}


	}
