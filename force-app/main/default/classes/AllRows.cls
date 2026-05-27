public class AllRows 
{
// Fetch all contact along with Deleted contacts.
	 
    public static void GetAllContWithDeletedCont()
    {
        Map <Id, Contact> mapCont = new Map<id, contact>([select id, firstname, lastname, email, title, phone,fax
                                                         from contact
                                                         ALL ROWS]);

        system.debug('Contact collection size is.... '+ mapCont.size());
        if(!mapCont.isEmpty())
        {
            for(Contact con : mapCont.values())
            {
                system.debug('Contact record is .... '+ con);
			}
        }
    }
}