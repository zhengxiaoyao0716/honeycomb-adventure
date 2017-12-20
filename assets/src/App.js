import React, { Component } from 'react';
import PropTypes from 'prop-types';

import { store } from './redux';
import Hello from './components/Hello';

class App extends Component {
    static childContextTypes = {
        store: PropTypes.object.isRequired,
        dispatch: PropTypes.func.isRequired,
    };
    getChildContext = () => ({ store, dispatch: store.dispatch });

    render() {
        return (<Hello />);
    }
}
export default App;
