//
//  File.swift
//  NubankFake
//
//  Created by João Felipe Schwaab on 11/11/25.
//

import UIKit


class RecargaCoordinator: Coordinator {
    // 1. Propriedades obrigatórias do protocolo
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    
    //dependencias que ele vai precisar
    private let recargaService: RecargaServiceProtocol
    private var paymentService = PaymentMethodServiceMock()
    
    
    // Precisa guardar o VM para reusar na Tela 4
    private var paymentViewModel: RecargaPaymentViewModel?
    
    //app vai chamar isso
    init(navigationController: UINavigationController, recargaService: RecargaServiceProtocol, paymentService: PaymentMethodServiceMock){
        
        self.navigationController = navigationController
        self.recargaService = recargaService
        self.paymentService = paymentService
        
    }
    
    // start fluxo da recarga
    func start() {
        mostrarTelaNumero()
    }
    
    //Primeira Tela do Numero
    private func mostrarTelaNumero(){
        
        //cria o viewModel e injeta o service
        let viewModel = RecargaNumeroViewModel(service: recargaService)
        
        //conecta as chamadas de sucess e error
        viewModel.didFinishInput = { [weak self] numero in
            self?.NavegaOperadora(numero: numero) //sucesso vai pra tela operadora, coloquei msm nome do diagrama
        }
        
        viewModel.didEncounterError = { [weak self] erro in
            self?.mostrarAlerta(mensagem: erro)
        }
        
        //cria a primeira tela
        let viewController = RecargaNumeroView(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
        
    }
    
    // Segunda Tela da operadora
    
    private func NavegaOperadora(numero: String){
        
        //cria viewmodel
        let viewModel = RecargaOperadoraViewModel(numero: numero)
        
        //conecta as chamadas
        viewModel.didSelectOperadora = { [weak self] operadora in
            self?.NavegaFormaPagamento(numero: numero, operadora: operadora) //sucess tela 3
        }
        
        //cria segunda tela
        let viewController = RecargaOperadoraView(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
        
    }
    
    // terceira tela de formas de pagamento
    private func NavegaFormaPagamento(numero: String, operadora: Operadora){
        
        let viewModel = RecargaPaymentViewModel(numero: numero, operadora: operadora, paymentService: paymentService)
        
        
        viewModel.didConfirmFormaPagamento = { [weak self] in
            self?.NavegaValorRecarga()
        }
        
        //guarda o vm no coordinator
        self.paymentViewModel = viewModel
    
        
        // ouve erros que View 3 vai usar
        viewModel.didFail = { [weak self] erro in
            self?.mostrarAlerta(mensagem: erro)
        }
        viewModel.dadosCarregados = {
            // (A View 3 ouve este, o Coordinator não precisa)
        }
        
        
        let viewController = RecargaPayment1View(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    
    
    private func NavegaValorRecarga(){
        // 1. Pega o ViewModel que ja existe
        guard let viewModel = self.paymentViewModel else { return }
        
        // ouve o callback da Tela 4
        viewModel.didFinishValor = { [weak self] in
            print("COORDINATOR: Recebeu 'Valor OK'. Próximo passo: Senha.")
            // self?.NavegaSenha() // proxima tela
        }
        
        
        viewModel.didFail = { [weak self] erro in
            self?.mostrarAlerta(mensagem: erro)
        }
        
        //cria tela 4
        let viewController = RecargaFormaPag2View(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    
    // Função auxiliar para mostrar o alerta
    private func mostrarAlerta(mensagem: String) {
        let alert = UIAlertController(title: "Atenção", message: mensagem, preferredStyle: .alert)
        
        // Cria o botão "OK"
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        // Adiciona o botão ao alerta
        alert.addAction(action)
        
        // O Coordinator tem o navigationController,
        // então ele pode "apresentar" o alerta.
        DispatchQueue.main.async {
            self.navigationController.present(alert, animated: true)
        }
    
    }
}



