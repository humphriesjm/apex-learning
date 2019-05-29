public with sharing class LeadTriggerHandler {
	// custom trigger handler setup to handle all triggers received on Lead objects
	
	private boolean myIsExecuting = false;
	private integer BatchSize = 0;
	
	// constuctor
	public LeadTriggerHandler(boolean isExecuting, integer size) {
		myIsExecuting = isExecuting;
		BatchSize = size;
	}
	
	// on before insert
	public void OnBeforeInsert(list<Lead> leadNew) {
		//
	}

	// on after insert
	public void OnAfterInsert(list<Lead> leadNew) {
		//
	}

	// on before update
	public void OnBeforeUpdate(map<id, Lead> mapOld, map<id, Lead> mapNew) {
		//
	}

	// on after update
	public void OnAfterUpdate(map<id, Lead> mapOld, map<id, Lead> mapNew) {
		//
	}

	// on before delete
	public void OnBeforeDelete(list<Lead> listExisting) {
		//
	}

	// on after delete
	public void OnAfterDelete(list<Lead> listExisting) {
		//
	}
	
	// on un delete
	public void OnUnDelete(list<Lead> listExisting) {
		//
	}
}