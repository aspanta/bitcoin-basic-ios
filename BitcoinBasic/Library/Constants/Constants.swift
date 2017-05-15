//
//  Constants.swift
//  EmercoinBasic
//

import Foundation

import UIKit

struct Constants {
    
    struct API {
        static let BaseURL = ""
        static let BitcoinCourse = "https://api.coinmarketcap.com/v1/ticker/bitcoin/?convert=USD"
        static let GetInfo = "getinfo"
        static let GetBlockchainInfo = "getblockchaininfo"
        static let GetTransactions = "listtransactions"
        static let GetBalance = "getbalance"
        static let SendCoins = "sendtoaddress"
        static let Fee = "settxfee"
        static let GetMyAddresses = "getaddressesbyaccount"
        static let GetNewMyAddress = "getnewaddress"
        static let AddName = "name_new"
        static let UpdateName = "name_update"
        static let DeleteName = "name_delete"
        static let SearchName = "name_show"
        static let GetNames = "name_list"
        static let ProtectWallet = "encryptwallet"
        static let LockWallet = "walletlock"
        static let UnlockWallet = "walletpassphrase"
    }
    
    static let MaxAmountCountNumbers = 15
    
    struct CellHeights {
        struct HomeBalanceCell {
            static let MoneyView = 95.0
            static let Collapsed = 70.0
        }
    }
    
    struct Permissions {
        static let PrintDeinit = true
        static let NeedAuth = true
        static let JsonBody = true
    }
    
    struct Colors {
        struct ContactCell {
            static let Edit = "d9743c"
            static let Delete = "da3975"
        }
        
        struct Coins {
            static let Bitcoin = "#fb8335"
            static let Emercoin = "#8C5DA3"
        }
        
        struct Status {
            static let Main = "#8a481d"
            static let Menu = "#3d3d3d"
            static let Bitcoin = "#8a481d"
            static let Settings = "#897295"
            static let Blockchain = "#5b5e7d"
        }
        
        struct TabBar {
            static let Tint = "#287580"
        }
        
        struct NavBar {
            static let Tint = "#2B7582"
            static let BarTint = "#8A58A4"
        }
    }
    
    struct Constraints {
        struct Login {
            struct Top {
                static let iphone5 = 20.0
            }
 
        }
    }
    
    struct Controllers {
        
        struct CoinsOperation {
            static let RecipientAddress = "Send Coins"
            static let Send = "Send Coins"
            static let MyAddress = "My Addresses"
            static let Get = "Receive Coins"
            static let History = "History"
    
        }
        
        struct Get {
            static let iphone5 = 40.0
        }
        
        struct Blockchain {
            
            static let HeaderColor = "8387B3"
        }
        
        struct Main {
            struct HeaderView {
                static let BitcoinColor = "#fb8335"
                static let BitcoinImage = "send_bit_icon"
            }
            struct StatusColor {
                static let BitcoinColor = "#8a481d"
            }
        }
        
        struct Menu {
            
            struct Home {
                static let Title = "Dashboard"
                static let Image = "menu_home_icon"
            }
            struct Send {
                static let Title = "Send Coins"
                static let Image = "menu_send_icon"
            }
            struct Get {
                static let Title = "Receive Coins"
                static let Image = "menu_get_icon"
            }
            struct History {
                static let Title = "Transaction History"
                static let Image = "menu_history_icon"
            }
            struct About {
                static let Title = "About"
                static let Image = "menu_about_icon"
            }
            struct Settings {
                static let Title = "Settings"
                static let Image = "menu_settings_icon"
            }
            
            struct Legal {
                static let Title = "Legal"
                static let Image = "menu_terms_icon"
            }
            
            struct Contacts {
                static let Title = "Feedback"
                static let Image = "menu_contacts_icon"
            }
            
            struct Exit {
                static let Title = "Logout"
                static let Image = "menu_exit_icon"
            }
            
            struct Book {
                static let Title = "Address Book"
                static let Image = "menu_book_icon"
            }
            
        }
        
        struct TabTitle {
            static let Home = "Dashboard"
            static let Send = "Send"
            static let Get = "Receive"
            static let Exchange = "Exchange"
            static let Names = "Names"
            static let History = "History"
        }
        
        struct TabImage {
            static let Home = "tab_home_icon"
            static let Send = "tab_send_icon"
            static let Get = "tab_get_icon"
            static let History = "tab_history_icon"
        }
    }

}
