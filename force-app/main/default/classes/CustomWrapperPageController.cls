public class CustomWrapperPageController 
{
    public List<CustomWrapper> lstWrapper {get; set;}
    
    public void DeleteSelectedRecord()
    {
        List<ID> recordsIdsTORemove = new List<ID>();
        
        if(! lstWrapper.isEmpty())
        {
            for( CustomWrapper wr : lstWrapper)
            {
            
                if(wr.isSelected == true)
                {
                    recordsIdsTORemove.Add(wr.recordId);
                }
            }
            
            if(! recordsIdsTORemove.isEmpty())
            {
                Database.Delete(recordsIdsTORemove);
            }
        }
    }
    
    public void SelectAllRecord()
    {
        if(! lstWrapper.isEmpty())
        {
            for( CustomWrapper wr : lstWrapper)
            {
                wr.isSelected = true;
            }
        }
    }
    
    public void DeSelectAllRecord()
    {
         if(! lstWrapper.isEmpty())
        {
            for( CustomWrapper wr : lstWrapper)
            {
                wr.isSelected = false;
            }
        }
    }
    
    public void LoadSobjectData()
    {
        lstWrapper = new List<CustomWrapper>();
        
        List<Contact> lstContact = [select id, firstName, lastName, email, phone, fax from contact limit 10];
        
        List<Lead> lstLead = [select id, firstName, lastName, email, phone, fax from Lead limit 10];
        
        if(! lstContact.isEmpty())
        {
            for(Contact con : lstContact)
            {
                lstWrapper.Add(new CustomWrapper(con, false));
            }
        }
        
        if(! lstLead.isEmpty())
        {
            for(Lead ld : lstLead)
            {
                lstWrapper.Add(new CustomWrapper(ld, false));
            }
        }
    }
}