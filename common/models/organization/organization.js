'use strict';

export default (Organization) =>  {
    Organization.defaultData = [
		{
            "name": "Centro POP",
            "desc_organization": "Centro de Referência Especializado para População em Situação de Rua",
			"cnpj": "12345678910123",
			"email": "centropop@centro.com",
			"endereco": "Rua Dom Pedro - 880",
			"fone": "(51)3078-0499"
		}
	];
};
