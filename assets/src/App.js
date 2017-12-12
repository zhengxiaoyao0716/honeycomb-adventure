import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { createStore } from 'redux';

import Hello from './components/Hello';

const actions = {
    hello: {
        replace: (state, { text }) => ({ ...state, text }),
    },
};
const store = createStore((state = { hello: { text: 'Hello world' } }, action) => {
    const fn = actions[action.type];
    return fn ? fn(state, action.payload) : state;
});

class App extends Component {
    static childContextTypes = {
        store: PropTypes.object.isRequired,
    };
    getChildContext = () => ({ store });

    render() {
        return (<Hello />);
    }
}
export default App;
