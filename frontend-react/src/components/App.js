import * as React from 'react';
import AppContent from '../components/AppContent';
import Header from '../components/Header';
import logo from '../logo.svg';
import viettelcloud from '../viettelcloud.svg'
import './App.css';

class App extends React.Component {
  render() {
    return (
      <div className="App">
        <Header logoSrc={viettelcloud} />
        <div className="container-fluid">
          <div className="row">
            <div className="col">
              <AppContent />
            </div>
          </div>
        </div>
      </div>
    );
  }
}

export default App;
