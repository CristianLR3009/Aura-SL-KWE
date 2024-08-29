@isTest
public class obtenerCursosCompletadosTest {
    @testSetup
    static void setupData() {
        // Crear datos de prueba
        Personal__c personal = new Personal__c(Name = 'John Doe');
        insert personal;

        Curso__c curso1 = new Curso__c(Name = 'Curso de Salesforce');
        Curso__c curso2 = new Curso__c(Name = 'Curso de Apex');
        insert new List<Curso__c>{curso1, curso2};

        Curso_Completado__c cursoCompletado1 = new Curso_Completado__c(
            Personal__c = personal.Id,
            Curso__c = curso1.Id,
            Fecha_de_inicio__c = Date.today(),
            Fecha_de_finalizaci_n__c = Date.today()
        );
        Curso_Completado__c cursoCompletado2 = new Curso_Completado__c(
            Personal__c = personal.Id,
            Curso__c = curso2.Id,
            Fecha_de_inicio__c = Date.today(),
            Fecha_de_finalizaci_n__c = Date.today().addDays(-10)
        );
        insert new List<Curso_Completado__c>{cursoCompletado1, cursoCompletado2};
    }

    @isTest
    static void testObtenerCursosCompletados() {
        // Obtener el Id del Personal creado en el testSetup
        Personal__c personal = [SELECT Id FROM Personal__c LIMIT 1];

        // Llamar al método en la clase que estamos probando
        List<Curso_Completado__c> cursos = obtenerCursosCompletados.obtenerCursosCompletados(personal.Id);

        // Verificar que se han recuperado correctamente los cursos completados
        System.assertEquals(2, cursos.size(), 'Debería haber 2 cursos completados para este usuario.');
        
        // Verificar que los nombres de los cursos son correctos
        Set<String> nombresDeCursos = new Set<String>();
        for (Curso_Completado__c curso : cursos) {
            nombresDeCursos.add(curso.Curso__r.Name);
        }
        System.assert(nombresDeCursos.contains('Curso de Salesforce'), 'Debería contener "Curso de Salesforce"');
        System.assert(nombresDeCursos.contains('Curso de Apex'), 'Debería contener "Curso de Apex"');
    }

    @isTest
    static void testObtenerCursosCompletadosNoResults() {
        // Crear un nuevo Personal sin cursos completados
        Personal__c newPersonal = new Personal__c(Name = 'Jane Doe');
        insert newPersonal;

        // Llamar al método en la clase que estamos probando
        List<Curso_Completado__c> cursos = obtenerCursosCompletados.obtenerCursosCompletados(newPersonal.Id);

        // Verificar que no se han recuperado cursos completados
        System.assertEquals(0, cursos.size(), 'No debería haber cursos completados para este usuario.');
    }
}
