//
//  RecargaPayment.swift
//  NubankFake
//
//  Created by Keitiely Silva Viana on 12/11/25.
//

import Foundation

class RecargaPaymentViewModel{
    
    //dados das telas anteriores
    let numero: String
    let operadora: Operadora
    
    
    // a VM conhece a service
    private let paymentService: PaymentMethodService
    
    
    //Estado (o que esta tela vai definir)
    var formaSelecionada: FormaPagamento?
    var valorSelecionado: Double?
    private(set) var saldoDisponivel: Double?  //saldo
    
    //callback para avisar o coordinator
    var didConfirmFormaPagamento: (() -> Void)? //tela 3 para 4
    var didFinishValor: (() -> Void)? // Tela 4 para 5
    var dadosCarregados: (() -> Void)? //  Para a View saber que o saldo chegou
    var didFail: ((String) -> Void)? // Para erros (Ex: saldo insuficiente)
    var isLoading: ((Bool) -> Void)? // Avisa a View quando está carregando
    
    init(numero: String, operadora: Operadora, paymentService: PaymentMethodService) {
        self.numero = numero
        self.operadora = operadora
        self.paymentService = paymentService // vm conhece o service
        print("ViewModel payment eu recebi o numero: \(numero) e a operadora: \(operadora)")
        
    }
    
    // A View tela 3 vai chamar isto para buscar o saldo
    func carregarDados() {
        print("ViewModel: Pedindo ao serviço para buscar dados...")
        
        paymentService.FetchUserData { [weak self] result in
            switch result {
            case .success(let user):
                //  Guarda o saldo
                self?.saldoDisponivel = user.accountBalance
                // Avisa a View Tela 3 que o saldo chegou
                self?.dadosCarregados?()
            case .failure:
                self?.didFail?("Erro ao buscar seu saldo")
            }
        }
    }
    
    
    //a view RecargaPayment1 vai chamar essa funcao
    func selectFormaPagamento(_ forma: FormaPagamento){
        self.formaSelecionada = forma
        print("Forma selecionada: \(forma)")
    }
    
    //a view RecargaPayment1 tmbm chama essa funcao
    func botaoConfirmarTocado(){
        if formaSelecionada != nil{
            //avisa o coordinator
            print("ViewModel paymant confirmado...avisando o coordinato")
            didConfirmFormaPagamento?()
        }
        else {
            print("ViewModel paymant nao confirmado... nao avisa o coordinato")
        }
    }
    
    
    // Tela 4 de escolha de Valores
    
    func selecionarValor(_ valor: Double){
        self.valorSelecionado = valor // armazenar numero
        print("Valor selecionado: R$ \(valor)")
    }
    
    func botaoRecarregarTocado() {
        // O VM só verifica se o usuário selecionou um valor
        
        guard let valorRecarga = valorSelecionado else {
            didFail?("Selecione um valor")
            return
        }
        
        isLoading?(true)
        // Prossegue nao faz validação de saldo
        self.paymentService.ValidarValor(valor: valorRecarga) { [weak self] (sucesso) in
            
            self?.isLoading?(false)
            if sucesso{
                self?.didFinishValor?()
            }
            else{
                self?.didFail?("Valor inválido")
            }
        }
    }
}

