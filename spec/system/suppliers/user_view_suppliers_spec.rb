require 'rails_helper'

describe 'User View Suppliers' do
  it 'success' do
    create(:supplier, name: 'Codeplay S.A.',
                      trade_name: 'Codeplay Vendas',
                      cnpj: '42.122.917/9093-10',
                      active: true)

    create(:supplier, name: 'Mercadonis S.A.',
                      trade_name: 'Mercadonis Vendas',
                      cnpj: '82.810.502/2387-18',
                      active: true)
    visit root_path
    click_on 'Fornecedores'

    expect(current_path).to eq(suppliers_path)
    expect(page).to have_content('Codeplay S.A.')
    expect(page).to have_content('Codeplay Vendas')
    expect(page).to have_content('42.122.917/9093-10')
    expect(page).to have_content('Mercadonis S.A.')
    expect(page).to have_content('Mercadonis Vendas')
    expect(page).to have_content('82.810.502/2387-18')
    expect(page).to have_link('Voltar', href: root_path)
  end

  it 'and there is none' do
    visit root_path
    click_on 'Fornecedores'

    expect(current_path).to eq(suppliers_path)
    expect(page).to have_content('Nenhum Fornecedor Cadastrado')
    expect(page).to have_link('Voltar', href: root_path)
  end

  it 'and see details from supplier' do
    supplier = create(:supplier, name: 'Codeplay S.A.',
                                 trade_name: 'Codeplay Vendas',
                                 cnpj: '42.122.917/9093-10',
                                 active: true)

    visit root_path
    click_on 'Fornecedores'
    click_on 'Codeplay S.A.'

    expect(current_path).to eq(supplier_path(supplier))
    expect(page).to have_content('Codeplay S.A.')
    expect(page).to have_content('Codeplay Vendas')
    expect(page).to have_content('42.122.917/9093-10')
    expect(page).to have_content('Ativado')
    expect(page).to have_link('Voltar', href: suppliers_path)
  end
  it 'and there is none' do
    visit root_path
    click_on 'Fornecedores'

    expect(current_path).to eq(suppliers_path)
    expect(page).to have_content('Nenhum Fornecedor Cadastrado')
    expect(page).to have_link('Voltar', href: root_path)
  end

  it 'and see details from a blocked supplier' do
    supplier = create(:supplier, name: 'Codeplay S.A.',
                                 trade_name: 'Codeplay Vendas',
                                 cnpj: '42.122.917/9093-10',
                                 active: false)

    visit root_path
    click_on 'Fornecedores'
    click_on 'Codeplay S.A.'

    expect(current_path).to eq(supplier_path(supplier))
    expect(page).to have_content('Codeplay S.A.')
    expect(page).to have_content('Codeplay Vendas')
    expect(page).to have_content('42.122.917/9093-10')
    expect(page).to have_content('Bloqueado')
    expect(page).to have_link('Voltar', href: suppliers_path)
  end
end
