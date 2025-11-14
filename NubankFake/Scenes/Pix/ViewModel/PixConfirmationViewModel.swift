//
//  PixConfirmationViewModel.swift
//  NubankFake
//
//  Created by Jota Pe on 12/11/25.
//

import Foundation

class PixConfirmationViewModel {
    
    // --- Dados de Entrada ---
    let pixData: PixData
    let value: Double
    
    // --- Callbacks de Navegação ---
    var onFinalConfirmation: ((PixData, Double) -> Void)?
    
    // --- Estado para a View (Propriedades Formatadas) ---
    var recipientName: String { pixData.recipientName }
    var recipientCPF: String { pixData.recipientCPF }
    var recipientBank: String { pixData.recipientBank }
    
    /// Formata o valor Double para a string de moeda (ex: "R$ 10,50")
    var valueString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: NSNumber(value: value)) ?? "R$ 0,00"
    }
    
    init(pixData: PixData, value: Double) {
        self.pixData = pixData
        self.value = value
    }
    
    /// Ação chamada pelo botão "Confirmar Pagamento" da View
    func confirmTransfer() {
        // Passa os dados para a próxima tela (a de Senha)
        onFinalConfirmation?(pixData, value)
    }
    
    
   //A view Model tem que pegar os dados do builder (que esta no coordinator), armazena-los e popula-los na pixConfirmationViewController, para os dados serem dinamicos
    // A viewModel tambem tem que ter referencia ao coordinator para que quando clicar no botao de confirmar, o pixCoordinator chame a proxima função (showPixValueScreen)
    // Essa função (showPixValueScreen) deve iniciar a viewController e a VM, passando o builder novamente para a VM, para que o builder popule o valor agora nessa tela
    // novamente a PixValueViewModel deve conter a referencia ao coordinator para chamar a proxima função do coordinator showSecondPixConfirmationScreen
    //Essa função (showSecondPixConfirmationScreen) deve iniciar a viewController e a VM. novamente o builder deve ser passado para a VM para os dados serem armazenados pela VM, e a VM conseguir distribuir dinamicamente os dados para a ViewController
}
