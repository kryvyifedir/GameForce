public with sharing class Constants {
	public static final String CREATED_LEADS_COUNTER_ID = 'CreatedLeadsCounter';
	public static final String CONVERTED_LEADS_COUNTER_ID = 'ConvertedLeadsCounter';
	public static final String COMPLETED_TASKS_COUNTER_ID = 'CompletedTasksCounter';
	public static final String CHATTER_POSTS_COUNTER_ID = 'ChatterPostsCounter';
	public static final String CLOSED_CASES_ID = 'ClosedCasesId';

	public static final Set<String> MEASUREMENT_UNIQUE_IDS = new Set<String> {
		CREATED_LEADS_COUNTER_ID, 
		CONVERTED_LEADS_COUNTER_ID, 
		COMPLETED_TASKS_COUNTER_ID, 
		CHATTER_POSTS_COUNTER_ID, 
		CLOSED_CASES_ID
	};

	public static final String CREATE_LEADS_1_NAME = 'Created Leads LVL1';
	public static final String CREATE_LEADS_2_NAME = 'Created Leads LVL2';
	public static final String CREATE_LEADS_3_NAME = 'Created Leads LVL3';
	public static final String CREATE_LEADS_4_NAME = 'Created Leads LVL4';
	public static final String CONVERTED_LEADS_1_NAME = 'Converted Leads LVL1';
	public static final String CONVERTED_LEADS_2_NAME = 'Converted Leads LVL2';
	public static final String CONVERTED_LEADS_3_NAME = 'Converted Leads LVL3';
	public static final String COMPLETED_TASKS_1_NAME = 'Completed Tasks LVL1';
	public static final String COMPLETED_TASKS_2_NAME = 'Completed Tasks LVL2';
	public static final String COMPLETED_TASKS_3_NAME = 'Completed Tasks LVL3';
	public static final String COMPLETED_TASKS_4_NAME = 'Completed Tasks LVL4';
	public static final String CHATTER_POSTS_1_NAME = 'Chatter Posts LVL1';
	public static final String CHATTER_POSTS_2_NAME = 'Chatter Posts LVL2';
	public static final String CHATTER_POSTS_3_NAME = 'Chatter Posts LVL3';
	public static final String CHATTER_POSTS_4_NAME = 'Chatter Posts LVL4';
	public static final String CLOSED_CASES_1_NAME = 'Cases Closed LVL1';
	public static final String CLOSED_CASES_2_NAME = 'Cases Closed LVL2';
	public static final String CLOSED_CASES_3_NAME = 'Cases Closed LVL3';

	public static final Set<String> ACHIEVEMENT_NAMES = new Set<String> {
		CREATE_LEADS_1_NAME,
		CREATE_LEADS_2_NAME,
		CREATE_LEADS_3_NAME,
		CREATE_LEADS_4_NAME,
		CONVERTED_LEADS_1_NAME,
		CONVERTED_LEADS_2_NAME,
		CONVERTED_LEADS_3_NAME,
		COMPLETED_TASKS_1_NAME,
		COMPLETED_TASKS_2_NAME,
		COMPLETED_TASKS_3_NAME,
		COMPLETED_TASKS_4_NAME,
		CHATTER_POSTS_1_NAME,
		CHATTER_POSTS_2_NAME,
		CHATTER_POSTS_3_NAME,
		CHATTER_POSTS_4_NAME,
		CLOSED_CASES_1_NAME,
		CLOSED_CASES_2_NAME,
		CLOSED_CASES_3_NAME
	};
}