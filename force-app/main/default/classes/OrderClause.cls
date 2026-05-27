public class OrderClause 
{
    public static void GetUnAssocon()
    {
        string conQuery = 'select id, firstname, lastname, email, phone, fax, title, birthdate from contact where accountid = null order by lastname asc';
       
        List<contact> lstcon = Database.query(conQuery);
        
        system.debug('collection size is.... '+ lstcon.size());
        
        if(! lstcon.isEmpty())
        {
            for(contact con : lstcon)
            {
                system.debug('contact record is..... '+ con);
            }
        }
        
    }

}