public with sharing class DataWrappers {
	
	public class UserCardData {
		@AuraEnabled
		public Id id { get; set; }
		@AuraEnabled
		public String name { get; set; }
		@AuraEnabled
		public String smallPhotoUrl { get; set; }
		@AuraEnabled
		public Decimal reachedAchievementsCount { get; set; }
		@AuraEnabled
		public Integer totalAchievementsCount { get; set; }
		@AuraEnabled
		public Decimal totalScore { get; set; }
	}

	public class AchievementCardData {
		@AuraEnabled
		public Id id { get; set; }
		@AuraEnabled
		public String uiTitle { get; set; }
		@AuraEnabled
		public String uiDescription { get; set; }
		@AuraEnabled
		public Decimal score { get; set; }
		@AuraEnabled
		public Boolean isReached { get; set; }
		@AuraEnabled
		public Long reachedDate { get; set; }
		@AuraEnabled
		public Id measurementId { get; set; }
		@AuraEnabled
		public String name { get; set; }
	}

	public class SeasonConfig {
		@AuraEnabled
		public Id id { get; set; }
		@AuraEnabled
		public Boolean isActive { get; set; }
		@AuraEnabled
		public String cadence { get; set; }
		@AuraEnabled
		public Date startDate { get; set; }
	}
}