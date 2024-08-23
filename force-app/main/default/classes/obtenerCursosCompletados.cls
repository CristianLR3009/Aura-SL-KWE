public with sharing class obtenerCursosCompletados {
    @AuraEnabled(cacheable=true)
    public static List<Curso_Completado__c> obtenerCursosCompletados(Id personalId) {
        try {
            return [
                SELECT Id, Curso__r.Name,  Fecha_de_inicio__c, Fecha_de_finalizaci_n__c
                FROM Curso_Completado__c WHERE Personal__R.Id = :personalId
            ];
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
