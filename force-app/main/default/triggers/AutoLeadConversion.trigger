trigger AutoLeadConversion on Lead (after update)
{
	if(trigger.isafter && trigger.isupdate)
    {
      LeadHandler.afterupdate(Trigger.new);
    }
}